module SimpleCov
  module Formatter
    class ShieldsBadge
      VERSION = "0.1.0"

      def format(result)
        coverage = result.covered_percent
        generate_badge(coverage)
        upload_to_gh_pages
      end

      private

      def generate_badge(coverage)
        %x(curl #{badge_url(coverage)} > badge.svg)
      end

      def badge_url(coverage)
        color = coverage_color(coverage)
        "https://img.shields.io/badge/coverage-#{coverage.round(2)}%25-#{color}.svg"
      end

      def coverage_color(coverage)
        case coverage
        when 0..20 then :red
        when 20..40 then :orange
        when 40..60 then :yellow
        when 60..80 then :yellowgreen
        when 80..90 then :green
        else :brightgreen
        end
      end

      def upload_to_gh_pages
        github_user  = ENV["GITHUB_USER"]
        github_mail  = ENV["GITHUB_MAIL"]
        github_org   = ENV["GITHUB_ORG"]
        github_repo  = ENV["GITHUB_REPO"]
        github_token = ENV["GITHUB_ACCESS_TOKEN"]

        return unless (github_user and github_mail and github_org and github_repo and github_token)

        %x(git remote remove upstream)
        %x(git remote add upstream 'https://#{github_token}@github.com/#{github_org}/#{github_repo}.git' > /dev/null 2> /dev/null)
        %x(git config --global user.name #{github_user})
        %x(git config --global user.email #{github_mail})
        %x(git fetch upstream)
        %x(git checkout gh-pages -f)
        %x(git reset -- .)
        %x(git add badge.svg)
        %x(git commit -a -m 'CI: Coverage for $COMMIT_ID')
        %x(git push upstream gh-pages:gh-pages)
      end
    end
  end
end
