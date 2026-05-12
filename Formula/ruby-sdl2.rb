# typed: false
# frozen_string_literal: true

class RubySdl2 < Formula
    desc "Ruby bindings for SDL2"
    homepage "https://github.com/link-coder100788/python-sdl2"
    url "https://github.com/link-coder100788/python-sdl2/archive/refs/tags/2.0.0.tar.gz"
    sha256 "ac53a47139900cb101a4dbe369dd18d2fe6cc67b34efd88156eff2702c831189"
    license "MIT"

    depends_on "cmake" => :build
    depends_on "sdl2"
    depends_on "openal-soft"
    depends_on "llvm"
    depends_on "ruby"

    def install
        system "cmake", "-S", ".", "-B", "build", "-DUSE_HOMEBREW_OPENAL=ON", "-DOpenAL_ROOT=$(brew --prefix openal-soft)", *std_cmake_args
        system "cmake", "--build", "build", "--target", "ruby_sdl2"
        lib.install Dir["build/ruby_sdl2.bundle"]
        (lib/"ruby").install "lib/ruby_sdl2.rb"
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

            If you want to have it on your path:
        
                echo "$(ruby_sdl2_env)" >> .zshrc
        EOS
    end
end

