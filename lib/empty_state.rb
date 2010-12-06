class Array
  extend ActionView::Helpers::TextHelper

  def each_with_empty_state(*args, &block)
    if args.size > 0
      begin
        view = args[0]
        options = args[1]
        if view && options.is_a?(Hash) && options[:empty_state]
          args.shift(2)
          if self.blank?
            empty_state = options[:empty_state]
            empty_state = :default if empty_state == true

            view.concat view.render(:partial => "#{empty_state}_empty_state", :locals => options[:locals])
          end
        end
      rescue ActionView::MissingTemplate => e
        raise e
      rescue Exception => e
        puts "Ignoring an error in each_with_empty_state: #{e}"
      end
    end

    # Default behavior for each
    each_without_empty_state *args, &block
  end

  alias :each_without_empty_state :each
  alias :each :each_with_empty_state
end
