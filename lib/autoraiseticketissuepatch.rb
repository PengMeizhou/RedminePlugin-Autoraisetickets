module Autoraiseticketissuepatch
  module Patches
    module IssuePatch
      @user = nil
      def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)        
        base.class_eval do
          unloadable
          
          before_save  :get_old_info
          after_save  :railse_tickets
          
          # Add visible to Redmine
          unless respond_to?(:visible)
            named_scope :visible, lambda {|*args| { :include => :project,
                                                    :conditions => Project.allowed_to_condition(args.first || User.current, :view_issues) } }
          end
        end
      end
    end
      
    module ClassMethods
    end
    
    module InstanceMethods
      @tracker_id = nil
      @subject_before = nil
      @subject_after = nil
      @status_before = nil
      @status_after = nil
      @relation_tracker_id = nil
      @some_commnets = "My Comments."
      
      def get_old_info
        logger.info '*********get_old_info start***************'
        oldissue = Issue.find_by_id(self.id.to_i) 
        @tracker_id = oldissue.tracker_id 
        @subject_before =  oldissue.subject
        @status_before = oldissue.status.id
        @relation_tracker_id = oldissue.tracker_id        
        logger.info '*********get_old_info end*****************'
      end  
      
      def railse_tickets
        logger.info '*********railse_tickets start***************'
        @subject_after =  self.subject
        @status_after = self.status.id
        
        if @status_after == 5 
          newticket = newticket || Autoraiseticket.new
          newticket.tracker_id=@tracker_id 
          newticket.subject_before = @subject_before
          newticket.subject_after = @subject_after
          newticket.status_before = @status_before
          newticket.status_after = @status_after
          newticket.relation_tracker_id = @relation_tracker_id 
          newticket.some_commnets = @some_commnets 
          newticket.save()
        end
        logger.info '*********railse_tickets end*****************'
      end        
    end
  end
end