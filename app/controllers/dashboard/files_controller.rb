module Dashboard
  class FilesController < ListsController
    self.solr_search_params_logic += [
      :show_only_files_deposited_by_current_user,
      :show_only_generic_files
    ]

    def index
      super
      @selected_tab = :files
    end
  end
end
