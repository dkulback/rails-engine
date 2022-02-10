class ErrorSerializer
  def self.json_invalid(message)
    {
      "message": 'your query could not be completed',
      "errors": message.record.errors.full_messages
    }
  end
end
