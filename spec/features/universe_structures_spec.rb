# frozen_string_literal: true

require "spec_helper"

describe "List all public structures" do
  context "without filter" do
    before { VCR.insert_cassette "esi/universe/structures" }

    after { VCR.eject_cassette }

    subject { EveOnline::ESI::UniverseStructures.new }

    specify { expect(subject.scope).to eq(nil) }

    specify { expect(subject.structure_ids.size).to eq(3654) }

    specify { expect(subject.structure_ids.first).to eq(1_027_528_548_355) }

    specify { expect(subject.error_limit_remain).to eq(100) }

    specify { expect(subject.error_limit_reset).to eq(35) }
  end

  context "with filter" do
    before { VCR.insert_cassette "esi/universe/structures_with_filter" }

    after { VCR.eject_cassette }

    subject { EveOnline::ESI::UniverseStructures.new(filter: "market") }

    specify { expect(subject.structure_ids.size).to eq(108) }

    specify { expect(subject.structure_ids.first).to eq(1_030_490_622_468) }

    specify { expect(subject.error_limit_remain).to eq(100) }

    specify { expect(subject.error_limit_reset).to eq(55) }
  end
end
