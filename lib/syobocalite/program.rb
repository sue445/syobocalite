module Syobocalite
  class Program
    # @!attribute pid
    #   @return [Integer]
    attr_accessor :pid

    # @!attribute tid
    #   @return [Integer]
    attr_accessor :tid

    # @!attribute st_time
    #   @return [TimeWithZone]
    attr_accessor :st_time

    # @!attribute ed_time
    #   @return [TimeWithZone]
    attr_accessor :ed_time

    # @!attribute ch_name
    #   @return [String]
    attr_accessor :ch_name

    # @!attribute ch_id
    #   @return [Integer]
    attr_accessor :ch_id

    # @!attribute count
    #   @return [Integer]
    attr_accessor :count

    # @!attribute st_offset
    #   @return [Integer]
    attr_accessor :st_offset

    # @!attribute sub_title
    #   @return [String]
    attr_accessor :sub_title

    # @!attribute title
    #   @return [String]
    attr_accessor :title

    # @!attribute prog_comment
    #   @return [String]
    attr_accessor :prog_comment

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
