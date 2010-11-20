require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../url_escaping")
require File.expand_path("#{File.dirname __FILE__}/address")
require File.expand_path("#{File.dirname __FILE__}/query_set")
require File.expand_path("#{File.dirname __FILE__}/query_unset_all")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _query-unset_ command.
class HTTY::CLI::Commands::QueryUnset < HTTY::CLI::Command

  include HTTY::CLI::UrlEscaping

  # Returns the name of a category under which help for the _query-unset_
  # command should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _query-unset_
  # command.
  def self.command_line_arguments
    'name'
  end

  # Returns the help text for the _query-unset_ command.
  def self.help
    "Removes a query-string parameter from the request's address"
  end

  # Returns the extended help text for the _query-unset_ command.
  def self.help_extended
    'Removes a query-string parameter used for the request. Does not ' +
    "communicate with the host.\n"                                     +
    "\n"                                                               +
    'The name of the query-string parameter will be URL-encoded if '   +
    "necessary.\n"                                                     +
    "\n"                                                               +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _query-unset_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::QuerySet,
     HTTY::CLI::Commands::QueryUnsetAll,
     HTTY::CLI::Commands::QueryAdd,
     HTTY::CLI::Commands::QueryRemove,
     HTTY::CLI::Commands::Address]
  end

  # Performs the _query-unset_ command.
  def perform
    add_request_if_has_response do |request|
      self.class.notify_if_cookies_cleared request do
        request.query_unset(*escape_or_warn_of_escape_sequences(arguments))
      end
    end
  end

end
