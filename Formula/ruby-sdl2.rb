# typed: false
# frozen_string_literal: true

class RubySdl2 < Formula
    desc "Ruby bindings for SDL2"
    homepage "https://github.com/link-coder100788/python-sdl2"
    url "https://github.com/link-coder100788/python-sdl2/archive/refs/tags/0.0.1.tar.gz"
    sha256 "33433bd8a41e7a322f933aa8649e7c9ec7e0250baaed6171627dbc572e1040dc"
    license "MIT"

    depends_on "cmake" => :build
    depends_on "sdl2"
    depends_on "openal-soft"
    depends_on "llvm"
    depends_on "ruby"

    def install
        system "cmake", "-S", ".", "-B", "build", "-DOpenAL_ROOT=$(brew --prefix openal-soft)", *std_cmake_args
        system "cmake", "--build", "build", "--target", "ruby_sdl2"
        lib.install Dir["build/ruby_sdl2.bundle"]
        (lib/"ruby").install "ruby_sdl2.rb"
        (bin/"ruby_sdl2_env").write <<~EOS
            #!/bin/bash
            echo 'export RUBYLIB="#{opt_lib}/ruby:$RUBYLIB"'
        EOS
        chmod "+x", bin/"ruby_sdl2_env"
    end

    def caveats
        <<~EOS
            To use ruby_sdl2:

                eval "$(ruby_sdl2_env)"
                ruby -e 'require "ruby_sdl2"'
        EOS
    end
end

