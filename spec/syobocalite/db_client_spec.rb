RSpec.describe Syobocalite::DbClient do
  let(:client) { Syobocalite::DbClient.new }

  describe "#get_program_flag" do
    subject { client.get_program_flag(tid: tid, pid: pid) }

    before do
      stub_request(:get, "https://cal.syoboi.jp/db.php?Command=ProgLookup&Fields=Flag&PID=634397&TID=679").
        to_return(status: 200, body: fixture("db_get_program_flag_pid_679_tid_634397.xml"))
    end

    let(:tid) { 679 }
    let(:pid) { 634397 }

    it { should eq 9 }
  end
end
