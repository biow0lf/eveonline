# frozen_string_literal: true

require "spec_helper"

describe EveOnline::ESI::ServerStatus do
  specify { expect(subject).to be_a(EveOnline::ESI::Base) }

  specify { expect(described_class::API_PATH).to eq("/v2/status/") }

  describe "#initialize" do
    its(:token) { should eq(nil) }

    its(:_read_timeout) { should eq(60) }

    its(:_open_timeout) { should eq(60) }

    its(:_write_timeout) { should eq(60) }
  end

  describe "#model" do
    context "when @model set" do
      let(:model) { instance_double(EveOnline::ESI::Models::ServerStatus) }

      before { subject.instance_variable_set(:@model, model) }

      specify { expect(subject.model).to eq(model) }
    end

    context "when @model not set" do
      let(:response) { double }

      before { expect(subject).to receive(:response).and_return(response) }

      let(:model) { instance_double(EveOnline::ESI::Models::ServerStatus) }

      before do
        #
        # EveOnline::ESI::Models::ServerStatus.new(response) # => model
        #
        expect(EveOnline::ESI::Models::ServerStatus).to receive(:new).with(response).and_return(model)
      end

      specify { expect { subject.model }.not_to raise_error }

      specify { expect { subject.model }.to change { subject.instance_variable_get(:@model) }.from(nil).to(model) }
    end
  end

  describe "#as_json" do
    let(:model) { instance_double(EveOnline::ESI::Models::ServerStatus) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:as_json) }

    specify { expect { subject.as_json }.not_to raise_error }
  end

  describe "#players" do
    let(:model) { instance_double(EveOnline::ESI::Models::ServerStatus) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:players) }

    specify { expect { subject.players }.not_to raise_error }
  end

  describe "#server_version" do
    let(:model) { instance_double(EveOnline::ESI::Models::ServerStatus) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:server_version) }

    specify { expect { subject.server_version }.not_to raise_error }
  end

  describe "#start_time" do
    let(:model) { instance_double(EveOnline::ESI::Models::ServerStatus) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:start_time) }

    specify { expect { subject.start_time }.not_to raise_error }
  end

  describe "#vip" do
    let(:model) { instance_double(EveOnline::ESI::Models::ServerStatus) }

    before { subject.instance_variable_set(:@model, model) }

    before { expect(model).to receive(:vip) }

    specify { expect { subject.vip }.not_to raise_error }
  end

  describe "#scope" do
    specify { expect(subject.scope).to eq(nil) }
  end

  describe "#path" do
    specify do
      expect(subject.path).to eq("/v2/status/")
    end
  end

  describe "#query" do
    specify do
      expect(subject.query).to eq({})
    end
  end

  describe "#url" do
    specify do
      expect(subject.url).to eq("https://esi.evetech.net/v2/status/")
    end
  end
end
