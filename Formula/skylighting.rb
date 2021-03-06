class Skylighting < Formula
  desc "Flexible syntax highlighter using KDE XML syntax descriptions"
  homepage "https://github.com/jgm/skylighting"
  url "https://github.com/jgm/skylighting/archive/0.8.5.tar.gz"
  sha256 "c77298809f7301b23bf2e8d479fde6be493bec42c36efce87ef37ac3bc27f112"
  head "https://github.com/jgm/skylighting.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ad47fed610330a0acdb8c452bae67188e7d6fe7c480bf77d009134767cdda8d2" => :catalina
    sha256 "5e42120c8f8a483d79f874f34d75173b94589bf202d694551af4ab3579f31524" => :mojave
    sha256 "d2d99c49b0aaea3c3d4cbfc672bb2ea9de65336b6eb696f59e6edc03cb962184" => :high_sierra
  end

  depends_on "cabal-install" => :build
  depends_on "ghc@8.8" => :build

  def install
    system "cabal", "v2-update"

    # moving this file aside during the first package's compilation avoids
    # spurious errors about undeclared autogenerated modules
    mv buildpath/"skylighting/skylighting.cabal", buildpath/"skylighting.cabal.temp-loc"
    system "cabal", "v2-install", buildpath/"skylighting-core", "-fexecutable", *std_cabal_v2_args
    mv buildpath/"skylighting.cabal.temp-loc", buildpath/"skylighting/skylighting.cabal"

    cd "skylighting" do
      system bin/"skylighting-extract", *Dir[buildpath/"skylighting-core/xml/*.xml"]
    end
    system "cabal", "v2-install", buildpath/"skylighting", "-fexecutable", *std_cabal_v2_args
  end

  test do
    (testpath/"Test.java").write <<~EOF
      import java.util.*;

      public class Test {
          public static void main(String[] args) throws Exception {
              final ArrayDeque<String> argDeque = new ArrayDeque<>(Arrays.asList(args));
              for (arg in argDeque) {
                  System.out.println(arg);
                  if (arg.equals("foo"))
                      throw new NoSuchElementException();
              }
          }
      }
    EOF
    expected_out = <<~EOF
      \\documentclass{article}
      \\usepackage[margin=1in]{geometry}
      \\usepackage{color}
      \\usepackage{fancyvrb}
      \\newcommand{\\VerbBar}{|}
      \\newcommand{\\VERB}{\\Verb[commandchars=\\\\\\{\\}]}
      \\DefineVerbatimEnvironment{Highlighting}{Verbatim}{commandchars=\\\\\\{\\}}
      % Add ',fontsize=\\small' for more characters per line
      \\usepackage{framed}
      \\definecolor{shadecolor}{RGB}{255,255,255}
      \\newenvironment{Shaded}{\\begin{snugshade}}{\\end{snugshade}}
      \\newcommand{\\AlertTok}[1]{\\textcolor[rgb]{0.75,0.01,0.01}{\\textbf{\\colorbox[rgb]{0.97,0.90,0.90}{\#1}}}}
      \\newcommand{\\AnnotationTok}[1]{\\textcolor[rgb]{0.79,0.38,0.79}{\#1}}
      \\newcommand{\\AttributeTok}[1]{\\textcolor[rgb]{0.00,0.34,0.68}{\#1}}
      \\newcommand{\\BaseNTok}[1]{\\textcolor[rgb]{0.69,0.50,0.00}{\#1}}
      \\newcommand{\\BuiltInTok}[1]{\\textcolor[rgb]{0.39,0.29,0.61}{\\textbf{\#1}}}
      \\newcommand{\\CharTok}[1]{\\textcolor[rgb]{0.57,0.30,0.62}{\#1}}
      \\newcommand{\\CommentTok}[1]{\\textcolor[rgb]{0.54,0.53,0.53}{\#1}}
      \\newcommand{\\CommentVarTok}[1]{\\textcolor[rgb]{0.00,0.58,1.00}{\#1}}
      \\newcommand{\\ConstantTok}[1]{\\textcolor[rgb]{0.67,0.33,0.00}{\#1}}
      \\newcommand{\\ControlFlowTok}[1]{\\textcolor[rgb]{0.12,0.11,0.11}{\\textbf{\#1}}}
      \\newcommand{\\DataTypeTok}[1]{\\textcolor[rgb]{0.00,0.34,0.68}{\#1}}
      \\newcommand{\\DecValTok}[1]{\\textcolor[rgb]{0.69,0.50,0.00}{\#1}}
      \\newcommand{\\DocumentationTok}[1]{\\textcolor[rgb]{0.38,0.47,0.50}{\#1}}
      \\newcommand{\\ErrorTok}[1]{\\textcolor[rgb]{0.75,0.01,0.01}{\\underline{\#1}}}
      \\newcommand{\\ExtensionTok}[1]{\\textcolor[rgb]{0.00,0.58,1.00}{\\textbf{\#1}}}
      \\newcommand{\\FloatTok}[1]{\\textcolor[rgb]{0.69,0.50,0.00}{\#1}}
      \\newcommand{\\FunctionTok}[1]{\\textcolor[rgb]{0.39,0.29,0.61}{\#1}}
      \\newcommand{\\ImportTok}[1]{\\textcolor[rgb]{1.00,0.33,0.00}{\#1}}
      \\newcommand{\\InformationTok}[1]{\\textcolor[rgb]{0.69,0.50,0.00}{\#1}}
      \\newcommand{\\KeywordTok}[1]{\\textcolor[rgb]{0.12,0.11,0.11}{\\textbf{\#1}}}
      \\newcommand{\\NormalTok}[1]{\\textcolor[rgb]{0.12,0.11,0.11}{\#1}}
      \\newcommand{\\OperatorTok}[1]{\\textcolor[rgb]{0.12,0.11,0.11}{\#1}}
      \\newcommand{\\OtherTok}[1]{\\textcolor[rgb]{0.00,0.43,0.16}{\#1}}
      \\newcommand{\\PreprocessorTok}[1]{\\textcolor[rgb]{0.00,0.43,0.16}{\#1}}
      \\newcommand{\\RegionMarkerTok}[1]{\\textcolor[rgb]{0.00,0.34,0.68}{\\colorbox[rgb]{0.88,0.91,0.97}{\#1}}}
      \\newcommand{\\SpecialCharTok}[1]{\\textcolor[rgb]{0.24,0.68,0.91}{\#1}}
      \\newcommand{\\SpecialStringTok}[1]{\\textcolor[rgb]{1.00,0.33,0.00}{\#1}}
      \\newcommand{\\StringTok}[1]{\\textcolor[rgb]{0.75,0.01,0.01}{\#1}}
      \\newcommand{\\VariableTok}[1]{\\textcolor[rgb]{0.00,0.34,0.68}{\#1}}
      \\newcommand{\\VerbatimStringTok}[1]{\\textcolor[rgb]{0.75,0.01,0.01}{\#1}}
      \\newcommand{\\WarningTok}[1]{\\textcolor[rgb]{0.75,0.01,0.01}{\#1}}
      \\title{#{testpath/"Test.java"}}
      
      \\begin{document}
      \\maketitle
      \\begin{Shaded}
      \\begin{Highlighting}[]
      \\KeywordTok{import}\\ImportTok{ java.util.*;}
      
      \\KeywordTok{public} \\KeywordTok{class}\\NormalTok{ Test \\{}
          \\KeywordTok{public} \\DataTypeTok{static} \\DataTypeTok{void} \\FunctionTok{main}\\NormalTok{(}\\BuiltInTok{String}\\NormalTok{[] args) }\\KeywordTok{throws} \\BuiltInTok{Exception}\\NormalTok{ \\{}
              \\DataTypeTok{final} \\BuiltInTok{ArrayDeque}\\NormalTok{\\textless{}}\\BuiltInTok{String}\\NormalTok{\\textgreater{} argDeque = }\\KeywordTok{new} \\BuiltInTok{ArrayDeque}\\NormalTok{\\textless{}\\textgreater{}(}\\BuiltInTok{Arrays}\\NormalTok{.}\\FunctionTok{asList}\\NormalTok{(args));}
              \\KeywordTok{for}\\NormalTok{ (arg in argDeque) \\{}
                  \\BuiltInTok{System}\\NormalTok{.}\\FunctionTok{out}\\NormalTok{.}\\FunctionTok{println}\\NormalTok{(arg);}
                  \\KeywordTok{if}\\NormalTok{ (arg.}\\FunctionTok{equals}\\NormalTok{(}\\StringTok{\"foo\"}\\NormalTok{))}
                      \\KeywordTok{throw} \\KeywordTok{new} \\BuiltInTok{NoSuchElementException}\\NormalTok{();}
      \\NormalTok{        \\}}
      \\NormalTok{    \\}}
      \\NormalTok{\\}}
      \\end{Highlighting}
      \\end{Shaded}
      
      \\end{document}
    EOF
    actual_out = shell_output("#{bin/"skylighting"} -f latex #{testpath/"Test.java"}")
    assert_equal actual_out.strip, expected_out.strip
  end
end
