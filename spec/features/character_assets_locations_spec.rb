# frozen_string_literal: true

require "spec_helper"

describe "Get character asset locations" do
  let(:options) do
    {
      character_id: 1_337_512_245,
      item_ids: [1_001_215_602_246],
      token: "token123"
    }
  end

  before { VCR.insert_cassette "esi/character_assets_locations/1337512245" }

  after { VCR.eject_cassette }

  subject { EveOnline::ESI::CharacterAssetsLocations.new(options) }

  specify { expect(subject.scope).to eq("esi-assets.read_assets.v1") }

  specify { expect(subject.not_modified?).to eq(false) }

  specify { expect(subject.assets_locations.size).to eq(1) }

  specify do
    expect(subject.assets_locations.first.as_json).to eq(item_id: 1_001_215_602_246)
  end

  specify do
    expect(subject.assets_locations.first.position.as_json).to eq(x: -928_621_543_221.3319,
      y: 297_645_715_142.40234,
      z: -971_212_198_300.4812)
  end

  specify { expect { subject.etag }.to raise_error(NotImplementedError) }

  specify { expect(subject.error_limit_remain).to eq(100) }

  specify { expect(subject.error_limit_reset).to eq(59) }
end
