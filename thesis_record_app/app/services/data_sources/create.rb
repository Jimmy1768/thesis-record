module DataSources
  class Create
    def self.call!(attributes:, actor:)
      DataSource.register!(attributes, actor: actor)
    end
  end
end
