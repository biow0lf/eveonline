# frozen_string_literal: true

require "spec_helper"

describe "Get item groups" do
  before { VCR.insert_cassette "esi/market/groups" }

  after { VCR.eject_cassette }

  subject { EveOnline::ESI::MarketGroups.new }

  specify { expect(subject.scope).to eq(nil) }

  specify { expect(subject.market_group_ids.size).to eq(1872) }

  specify { expect(subject.market_group_ids.first).to eq(2) }

  specify { expect(subject.error_limit_remain).to eq(100) }

  specify { expect(subject.error_limit_reset).to eq(49) }
end
