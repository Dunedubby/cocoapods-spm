require "cocoapods-spm/resolver/validator"
require "cocoapods-spm/resolver/umbrella_package"

module Pod
  module SPM
    class Resolver
      require "cocoapods-spm/resolver/result"
      require "cocoapods-spm/resolver/target_dep_resolver"
      require "cocoapods-spm/resolver/recursive_target_resolver"

      def initialize(podfile, aggregate_targets)
        @_result = Result::WritableResult.new
        @podfile = podfile
        @aggregate_targets = aggregate_targets
        @umbrella_pkg = nil
        @target_resolver = TargetDependencyResolver.new(podfile, aggregate_targets, @_result)
        @recursive_resolver = RecursiveTargetResolver.new(podfile, @_result)
      end

      def resolve
        @target_resolver.resolve
        generate_umbrella_pkg
        @recursive_resolver.resolve
        validate!
      end

      def result
        @result ||= @_result.to_read_only
      end

      private

      def generate_umbrella_pkg
        @umbrella_pkg = Pod::SPM::UmbrellaPackage.new(
          @podfile,
          @target_resolver.all_spm_pkgs,
        ).prepare
      end

      def validate!
        Validator.new(@aggregate_targets, result).validate!
      end
    end
  end
end
