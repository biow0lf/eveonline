# frozen_string_literal: true

require "spec_helper"

describe EveOnline::ESI::Models::Race do
  it { should be_a(EveOnline::ESI::Models::Base) }

  let(:options) { double }

  subject { described_class.new(options) }

  describe "#initialize" do
    its(:options) { should eq(options) }
  end

  describe "#as_json" do
    let(:races) { described_class.new(options) }

    before { expect(races).to receive(:faction_id).and_return(500_002) }

    before { expect(races).to receive(:description).and_return("Once a thriving tribal civilization, the Minmatar...") }

    before { expect(races).to receive(:name).and_return("Minmatar") }

    before { expect(races).to receive(:id).and_return(2) }

    subject { races.as_json }

    its([:faction_id]) { should eq(500_002) }

    its([:description]) { should eq("Once a thriving tribal civilization, the Minmatar...") }

    its([:name]) { should eq("Minmatar") }

    its([:id]) { should eq(2) }
  end

  describe "#faction_id" do
    before { expect(options).to receive(:[]).with("alliance_id") }

    specify { expect { subject.faction_id }.not_to raise_error }
  end

  describe "#description" do
    before { expect(options).to receive(:[]).with("description") }

    specify { expect { subject.description }.not_to raise_error }
  end

  describe "#name" do
    before { expect(options).to receive(:[]).with("name") }

    specify { expect { subject.name }.not_to raise_error }
  end

  describe "#id" do
    before { expect(options).to receive(:[]).with("race_id") }

    specify { expect { subject.id }.not_to raise_error }
  end
end
