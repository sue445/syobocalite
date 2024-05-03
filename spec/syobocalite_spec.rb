RSpec.describe Syobocalite do
  describe ".search" do
    subject(:programs) { Syobocalite.search(start_at: start_at, end_at: end_at) }

    before do
      stub_request(:get, "https://cal.syoboi.jp/cal_chk.php?days=1&start=2017-05-07").
        to_return(status: 200, body: fixture("cal_chk_20170507.xml"))

      stub_request(:get, "https://cal.syoboi.jp/cal_chk.php?days=2&start=2017-05-06").
        to_return(status: 200, body: fixture("cal_chk_20170506-20170507.xml"))
    end

    context "start_at < 05:00:00" do
      let(:start_at) { "2017-05-07 00:00:00".in_time_zone }
      let(:end_at)   { "2017-05-07 00:30:00".in_time_zone }

      its(:count) { should eq 12 }

      describe "[0]" do
        subject { programs[0] }

        its(:ch_id)        { should eq 20 }
        its(:ch_name)      { should eq "AT-X" }
        its(:title)        { should eq "サクラダリセット" }
        its(:sub_title)    { should eq "ビー玉世界とキャンディーレジスト" }
        its(:story_number) { should eq 5 }
        its(:st_time)      { should eq "2017-05-07 00:00:00".in_time_zone }
        its(:ed_time)      { should eq "2017-05-07 00:30:00".in_time_zone }
      end
    end

    context "start_at >= 05:00:00" do
      let(:start_at) { "2017-05-07 08:30:00".in_time_zone }
      let(:end_at)   { "2017-05-07 09:00:00".in_time_zone }

      its(:count) { should eq 7 }

      describe "[0]" do
        subject { programs[0] }

        its(:ch_id)        { should eq 77 }
        its(:ch_name)      { should eq "東海テレビ" }
        its(:title)        { should eq "モンスターハンター ストーリーズ RIDE ON" }
        its(:sub_title)    { should eq "森となり獣となれ" }
        its(:story_number) { should eq 31 }
        its(:st_time)      { should eq "2017-05-07 08:30:00".in_time_zone }
        its(:ed_time)      { should eq "2017-05-07 09:00:00".in_time_zone }
      end
    end

    context "contains html entity" do
      before do
        stub_request(:get, "https://cal.syoboi.jp/cal_chk.php?days=1&start=2018-05-02").
          to_return(status: 200, body: fixture("cal_chk_20180502.xml"))
      end

      let(:start_at) { "2018-05-02 19:30:00".in_time_zone }
      let(:end_at)   { "2018-05-02 20:00:00".in_time_zone }

      describe "[1]" do
        subject { programs[1] }

        its(:ch_id)        { should eq 19 }
        its(:ch_name)      { should eq "TOKYO MX" }
        its(:title)        { should eq "魔法つかいプリキュア！" }
        its(:sub_title)    { should eq "Let'sエンジョイ！魔法学校の夏休み！" }
        its(:story_number) { should eq 27 }
        its(:st_time)      { should eq "2018-05-02 19:30:00".in_time_zone }
        its(:ed_time)      { should eq "2018-05-02 20:00:00".in_time_zone }
      end
    end
  end
end
