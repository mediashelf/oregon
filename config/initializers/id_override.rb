
module ActiveFedora
  class UnsavedDigitalObject
    def assign_pid
      @pid ||= OregonDigital::IdService.mint
    end
  end
end
