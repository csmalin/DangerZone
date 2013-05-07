require "spec_helper"

describe Crime do 
	
	before do
	  @crime = Crime.create(:incidntnum   => 130243190,
	          					 :category     => "ARSON",
	          					 :descript     => "ATTEMPTED ARSON",
	          					 :dayofweek    => "Sunday",
	          					 :date         => "2013-03-24",
	          					 :time         => 480,
	          					 :pddistrict   => "TARAVAL",
	          					 :resolution   => "ARREST, BOOKED",
	          					 :address      => "1700 Block of 27TH AV",
	          					 :latitude     => 37.78486569,
	          					 :longitude    => -122.4127841
	          					 )
	end

	subject { @crime }

	it { should respond_to(:incidntnum) }
	it { should respond_to(:category) }
	it { should respond_to(:descript) }
	it { should respond_to(:dayofweek) }
	it { should respond_to(:date) }
	it { should respond_to(:time) }
	it { should respond_to(:pddistrict) }
	it { should respond_to(:resolution) }
	it { should respond_to(:address) }
	it { should respond_to(:latitude) }
	it { should respond_to(:longitude) }
	it { should respond_to(:threat_level) }

	it { should validate_uniqueness_of(:incidntnum) }

	describe "when threat level is saved" do
		before { @crime.save }
		its(:threat_level) { should eq(2) }
	end

	describe "when time is saved" do
		before { @crime.save }
		its(:time) { should be_between(0,1440) }
	end
end