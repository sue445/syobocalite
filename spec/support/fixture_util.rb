module FixtureUtil
  def fixture(filename)
    spec_dir.join("fixtures", filename).read
  end
end
