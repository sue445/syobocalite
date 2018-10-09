module Syobocalite
  class Program
    attr_accessor :pid, :tid, :st_time, :ed_time, :ch_name, :ch_id, :count, :st_offset, :sub_title, :title, :prog_comment

    # @param attrs [Hash]
    def initialize(attrs = {})
      @pid          = attrs["PID"]&.to_i
      @tid          = attrs["TID"]&.to_i
      @st_time      = to_time(attrs["StTime"])
      @ed_time      = to_time(attrs["EdTime"])
      @ch_name      = attrs["ChName"]
      @ch_id        = attrs["ChID"]&.to_i
      @count        = attrs["Count"]&.to_i
      @st_offset    = attrs["StOffset"]&.to_i
      @sub_title    = sanitize_text(attrs["SubTitle"])
      @title        = sanitize_text(attrs["Title"])
      @prog_comment = attrs["ProgComment"]&.gsub(/^!/, "")
    end

    alias_method :story_number,  :count
    alias_method :story_number=, :count=

    private

    def to_time(str)
      return nil unless str

      Time.use_zone("Tokyo") do
        Time.zone.parse(str)
      end
    end

    def sanitize_text(str)
      return nil unless str

      CGI.unescapeHTML(str)
    end
  end
end
