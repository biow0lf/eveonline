# frozen_string_literal: true

require "spec_helper"

describe "Get alliance history" do
  let(:options) { {corporation_id: 98_134_807} }

  before { VCR.insert_cassette "esi/corporation_alliance_history/98134807" }

  after { VCR.eject_cassette }

  subject { EveOnline::ESI::CorporationAllianceHistory.new(options) }

  specify { expect(subject.scope).to eq(nil) }

  specify { expect(subject.entries.size).to eq(12) }

  specify do
    expect(subject.entries.first.as_json).to eq(alliance_id: 99_005_874,
      is_deleted: nil,
      record_id: 1_254_640,
      start_date: "2019-06-03T00:17:00Z")
  end

  specify { expect(subject.error_limit_remain).to eq(100) }

  specify { expect(subject.error_limit_reset).to eq(35) }
end
