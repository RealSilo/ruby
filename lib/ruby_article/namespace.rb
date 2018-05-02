module Racing
  module Car
    class Body
      def reload
        print 'Adding gas'
      end
    end
  end

  module Driver
    class Body
      def hydrate
        print 'Drinking'
      end
    end
  end
end

Car::Body.new.reload
Driver::Body.new.hydrate
