 module ControllerMacros
  include Warden::Test::Helpers
    def sign_in_resource(resource_or_scope, resource = nil)
      resource ||= resource_or_scope
      scope = Devise::Mapping.find_scope!(resource_or_scope)
      login_as(resource, scope: scope)
    end
    def sign_out_resource(resource_or_scope)
      scope = Devise::Mapping.find_scope!(resource_or_scope)
      logout(scope)
    end
    def execute_with_resource_sign_in(resource_or_scope, &block)
      sign_in_resource(resource_or_scope)
      yield
      sign_out_resource(resource_or_scope)
    end
 end

# module ControllerMacros
#   def login_user
#    before(:each) do
#     @request.env["devise.mapping"] = Devise.mappings[:user]
#     user = FactoryGirl.create(:user)
#     user.confirm! #only if account is confirmable
#     sign_in user
#    end
#   end
# end