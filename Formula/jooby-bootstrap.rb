class JoobyBootstrap < Formula
  desc "Script to simplify the creation of jooby apps"
  homepage "https://github.com/jooby-project/jooby-bootstrap"
  url "https://github.com/jooby-project/jooby-bootstrap/archive/0.2.2.tar.gz"
  sha256 "ba662dcbe9022205cdb147a1c4e0931191eb902477ca40f3cba0170dfad54fda"
  license "Apache-2.0"
  revision 1

  bottle :unneeded

  depends_on :java => "1.8"
  depends_on "maven"

  def install
    libexec.install "jooby"
    (bin/"jooby").write_env_script libexec/"jooby", Language::Java.java_home_env("1.8")
  end

  test do
    system "#{bin}/jooby", "version"
  end
end
