# frozen_string_literal: true

require "spec_helper"

describe "Get system kills" do
  before { VCR.insert_cassette "esi/universe/system_kills" }

  after { VCR.eject_cassette }

  subject { EveOnline::ESI::UniverseSystemKills.new }

  specify { expect(subject.scope).to eq(nil) }

  specify { expect(subject.system_kills.size).to eq(3194) }

  specify do
    expect(subject.system_kills.first.as_json).to eq(npc_kills: 89,
      pod_kills: 0,
      ship_kills: 5,
      system_id: 30_005_327)
  end

  specify { expect(subject.error_limit_remain).to eq(100) }

  specify { expect(subject.error_limit_reset).to eq(32) }
end
