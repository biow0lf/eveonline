# frozen_string_literal: true

require 'spec_helper'

describe EveOnline::ESI::CorporationOrders do
  let(:options) { { token: 'token123', corporation_id: 12_345_678 } }

  subject { described_class.new(options) }

  specify { expect(subject).to be_a(EveOnline::ESI::Base) }

  specify { expect(described_class::API_ENDPOINT).to eq('https://esi.evetech.net/v3/corporations/%<corporation_id>s/orders/?datasource=%<datasource>s&page=%<page>s') }

  describe '#initialize' do
    context 'without options' do
      its(:token) { should eq('token123') }

      its(:parser) { should eq(JSON) }

      its(:_read_timeout) { should eq(60) }

      its(:_open_timeout) { should eq(60) }

      its(:datasource) { should eq('tranquility') }

      its(:corporation_id) { should eq(12_345_678) }

      its(:page) { should eq(1) }
    end

    context 'with options' do
      let(:options) { { token: 'token123', corporation_id: 12_345_678, page: 10 } }

      its(:page) { should eq(10) }
    end
  end

  describe '#orders' do
    let(:order) { double }

    let(:response) do
      [
        {
          'order_id' => 123,
          'type_id' => 456,
          'region_id' => 123,
          'location_id' => 456,
          'range' => 'station',
          'is_buy_order' => true,
          'price' => 33.3,
          'volume_total' => 123_456,
          'volume_remain' => 4422,
          'issued' => '2016-09-03T05:12:25Z',
          'state' => 'open',
          'min_volume' => 1,
          'wallet_division' => 1,
          'duration' => 30,
          'escrow' => 45.6
        }
      ]
    end

    before do
      #
      # subject.response # => [{"order_id"=>123, "type_id"=>456, "region_id"=>123, "location_id"=> 456, "range"=>"station", "is_buy_order"=>true, "price"=>33.3, "volume_total"=>123456, "volume_remain"=>4422, "issued"=>"2016-09-03T05:12:25Z", "state"=>"open", "min_volume"=>1, "wallet_division"=>1, "duration"=>30, "escrow"=>45.6}]
      #
      expect(subject).to receive(:response).and_return(response)
    end

    before do
      #
      # EveOnline::ESI::Models::CorporationOrder.new(response.first) # => order
      #
      expect(EveOnline::ESI::Models::CorporationOrder).to receive(:new).with(response.first).and_return(order)
    end

    specify { expect(subject.orders).to eq([order]) }

    specify { expect { subject.orders }.to change { subject.instance_variable_defined?(:@_memoized_orders) }.from(false).to(true) }
  end

  # TODO: remove duplication
  describe '#total_pages' do
    let(:resource) { double }

    let(:headers) { double }

    let(:pages) { double }

    before { expect(subject).to receive(:resource).and_return(resource) }

    before { expect(resource).to receive(:headers).and_return(headers) }

    before { expect(headers).to receive(:[]).with('x-pages').and_return(pages) }

    before { expect(pages).to receive(:to_i) }

    specify { expect { subject.total_pages }.not_to raise_error }
  end

  describe '#scope' do
    specify { expect(subject.scope).to eq('esi-markets.read_corporation_orders.v1') }
  end

  describe '#url' do
    specify do
      expect(subject.url).to eq('https://esi.evetech.net/v3/corporations/12345678/orders/?datasource=tranquility&page=1')
    end
  end
end
