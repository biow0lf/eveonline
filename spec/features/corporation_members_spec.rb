# frozen_string_literal: true

require "spec_helper"

describe "Get corporation members" do
  let(:options) do
    {
      corporation_id: 98_565_696,
      token: "token123"
    }
  end

  before { VCR.insert_cassette "esi/corporation_members/98565696" }

  after { VCR.eject_cassette }

  subject { EveOnline::ESI::CorporationMembers.new(options) }

  specify { expect(subject.scope).to eq("esi-corporations.read_corporation_membership.v1") }

  specify { expect(subject.character_ids.size).to eq(118) }

  specify { expect(subject.character_ids.first).to eq(2_114_220_544) }

  specify { expect(subject.error_limit_remain).to eq(100) }

  specify { expect(subject.error_limit_reset).to eq(50) }
end
