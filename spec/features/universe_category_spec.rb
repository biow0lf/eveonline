# frozen_string_literal: true

require "spec_helper"

describe "Get item category information" do
  before { VCR.insert_cassette "esi/universe/categories/6" }

  after { VCR.eject_cassette }

  let(:options) { {category_id: 6} }

  subject { EveOnline::ESI::UniverseCategory.new(options) }

  specify { expect(subject.scope).to eq(nil) }

  specify do
    expect(subject.as_json).to eq(id: 6,
      name: "Ship",
      published: true)
  end

  specify { expect(subject.group_ids.size).to eq(47) }

  specify { expect(subject.group_ids.first).to eq(25) }

  specify { expect(subject.error_limit_remain).to eq(100) }

  specify { expect(subject.error_limit_reset).to eq(15) }
end
