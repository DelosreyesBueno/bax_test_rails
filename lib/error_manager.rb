class ErrorManager
  ERRORS_FILE_PATH = Rails.root.join('config', 'errors.json')

  def self.load_errors
    @errors ||= JSON.parse(File.read(ERRORS_FILE_PATH))
  end

  def self.error(errors_key)
    load_errors[errors_key.to_s]
  end
end