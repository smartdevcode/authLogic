# frozen_string_literal: true

module Authlogic
  # Parent class of all Authlogic errors.
  class Error < StandardError
  end

  # :nodoc:
  class InvalidCryptoProvider < Error
  end

  # :nodoc:
  class NilCryptoProvider < InvalidCryptoProvider
    def message
      <<~EOS
        In version 5, Authlogic used SCrypt by default. As of version 6, there
        is no default. We still recommend SCrypt. If you previously relied on
        this default, then, in your User model (or equivalent), please set the
        following:

            acts_as_authentic do |c|
              c.crypto_provider = ::Authlogic::CryptoProviders::SCrypt
            end

        Furthermore, the authlogic gem no longer depends on the scrypt gem. In
        your Gemfile, please add scrypt.

            gem "scrypt", "~> 3.0"

        We have made this change in Authlogic 6 so that users of other crypto
        providers no longer need to install the scrypt gem.
      EOS
    end
  end

  # :nodoc:
  class ModelSetupError < Error
    def message
      <<-EOS
        You must establish a database connection and run the migrations before
        using acts_as_authentic. If you need to load the User model before the
        database is set up correctly, please set the following:

            acts_as_authentic do |c|
              c.raise_on_model_setup_error = false
            end
      EOS
    end
  end
end
