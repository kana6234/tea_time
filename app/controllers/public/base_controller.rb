class Public::BaseController < ApplicationController
  before_action :authenticate_user!, if: :use_auth? , except: [:index, :search]
  def use_auth?
    if action_name == 'show'
      if controller_name == 'favorites' || controller_name == 'bookmarks'
      true
      end
    else
      true
    end
  end
end
