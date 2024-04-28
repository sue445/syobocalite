require "syobocalite/version"
require "syobocalite/program"
require "syobocalite/db_client"
require "active_support/all"
require "multi_xml"
require "open-uri"

module Syobocalite
  # Search programs between `start_at` and `end_at`
  #
  # @param start_at [Time]
  # @param end_at [Time]
  #
  # @return [Array<Program>]
  #
  # @see https://docs.cal.syoboi.jp/spec/cal_chk.php/
  def self.search(start_at:, end_at:)
    xml = fetch(start_at: start_at, end_at: end_at)
    response = MultiXml.parse(xml)
    prog_items = response["syobocal"]["ProgItems"]["ProgItem"]

    programs = prog_items.map { |prog_item| Syobocalite::Program.from_prog_item(prog_item) }

    programs.select do |program|
      (start_at...end_at).cover?(program.st_time)
    end
  end

  # @return [String]
  def self.user_agent
    "Syobocalite v#{Syobocalite::VERSION}"
  end

  def self.fetch(start_at:, end_at:)
    params = {}

    if start_at.hour >= 5
      params[:days]  = (end_at.to_date - start_at.to_date).to_i + 1
      params[:start] = start_at.strftime("%Y-%m-%d")
    else
      # NOTE: If start_at is 2018/4/7, returns 2018/4/7 05:00 - 28:59(2018/4/8 04:59)
      params[:days]  = (end_at.to_date - start_at.to_date).to_i + 2
      params[:start] = (start_at - 1.day).strftime("%Y-%m-%d")
    end

    headers = {
      "User-Agent" => user_agent,
    }

    URI.open("http://cal.syoboi.jp/cal_chk.php?#{params.to_param}", headers).read
  end
  private_class_method :fetch
end
