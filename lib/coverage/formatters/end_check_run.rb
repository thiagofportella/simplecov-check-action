# frozen_string_literal: true

module Formatters
  class EndCheckRun
    GITHUB_CHECK_NAME = "SimpleCov"
    GITHUB_API_URL = "https://api.github.com/repos"

    def initialize(repo:, sha:, check_id:, payload_adapter:)
      @repo = repo
      @sha = sha
      @check_id = check_id
      @payload_adapter = payload_adapter
    end

    def as_uri
      "#{GITHUB_API_URL}/#{@repo}/check-runs/#{@check_id}"
    end

    def as_payload
      {
        name: GITHUB_CHECK_NAME,
        head_sha: @sha,
        status: "completed",
        completed_at: Time.now.iso8601,
        conclusion: @payload_adapter.conclusion,
        output: {
          title: @payload_adapter.title,
          summary: @payload_adapter.summary,
          text: @payload_adapter.text,
          annotations: []
        }
      }
    end
  end
end