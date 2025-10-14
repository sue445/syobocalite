module Syobocalite
  # API client for https://cal.syoboi.jp/db.php
  # @see https://docs.cal.syoboi.jp/spec/db.php/
  class DbClient
    # Get program's flag
    # @param tid [Integer]
    # @param pid [Integer]
    # @return [Integer]
    # @see https://docs.cal.syoboi.jp/spec/proginfo-flag/
    def get_program_flag(tid:, pid:)
      params = {
        "Command" => "ProgLookup",
        "Fields" => "Flag",
        "TID" => tid,
        "PID" => pid,
      }

      headers = {
        "User-Agent" => Syobocalite.user_agent,
      }

      xml = Syobocalite.with_retry do
        URI.open("https://cal.syoboi.jp/db.php?#{params.to_param}", headers).read
      end
      response = MultiXml.parse(xml)
      response["ProgLookupResponse"]["ProgItems"]["ProgItem"]["Flag"].to_i
    end
  end
end
