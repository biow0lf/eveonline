# frozen_string_literal: true

require "spec_helper"

describe EveOnline::ESI::CharacterBlueprints do
  let(:options) { {token: "token123", character_id: 12_345_678} }

  subject { described_class.new(options) }

  specify { expect(subject).to be_a(EveOnline::ESI::Base) }

  specify { expect(described_class::API_PATH).to eq("/v3/characters/%<character_id>s/blueprints/") }

  describe "#initialize" do
    context "without options" do
      its(:token) { should eq("token123") }

      its(:_read_timeout) { should eq(60) }

      its(:_open_timeout) { should eq(60) }

      its(:_write_timeout) { should eq(60) }

      its(:character_id) { should eq(12_345_678) }

      its(:page) { should eq(1) }
    end

    context "with options" do
      let(:options) { {token: "token123", character_id: 12_345_678, page: 10} }

      its(:page) { should eq(10) }
    end
  end

  describe "#blueprints" do
    context "when @blueprints set" do
      let(:blueprints) { [instance_double(EveOnline::ESI::Models::Blueprint)] }

      before { subject.instance_variable_set(:@blueprints, blueprints) }

      specify { expect(subject.blueprints).to eq(blueprints) }
    end

    context "when @blueprints not set" do
      let(:blueprint) { instance_double(EveOnline::ESI::Models::Blueprint) }

      let(:response) do
        [
          {
            item_id: 716_338_097,
            type_id: 1010,
            location_id: 61_000_032,
            location_flag: "Hangar",
            quantity: -2,
            time_efficiency: 0,
            material_efficiency: 10,
            runs: 300
          }
        ]
      end

      before do
        #
        # subject.response # => [{"item_id"=>716338097, "type_id"=>1010, "location_id"=>61000032, "location_flag"=>"Hangar", "quantity"=>-2, "time_efficiency"=>0, "material_efficiency"=>10, "runs"=>300}]
        #
        expect(subject).to receive(:response).and_return(response)
      end

      before do
        #
        # EveOnline::ESI::Models::Blueprint.new(response.first) # => blueprint
        #
        expect(EveOnline::ESI::Models::Blueprint).to receive(:new).with(response.first).and_return(blueprint)
      end

      specify { expect(subject.blueprints).to eq([blueprint]) }

      specify { expect { subject.blueprints }.to change { subject.instance_variable_get(:@blueprints) }.from(nil).to([blueprint]) }
    end
  end

  describe "#scope" do
    specify { expect(subject.scope).to eq("esi-characters.read_blueprints.v1") }
  end

  describe "#additional_query_params" do
    specify { expect(subject.additional_query_params).to eq([:page]) }
  end

  describe "#path" do
    specify do
      expect(subject.path).to eq("/v3/characters/12345678/blueprints/")
    end
  end

  describe "#query" do
    specify do
      expect(subject.query).to eq(page: 1)
    end
  end

  describe "#url" do
    specify do
      expect(subject.url).to eq("https://esi.evetech.net/v3/characters/12345678/blueprints/?page=1")
    end
  end
end
