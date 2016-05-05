class HookExecutionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    hook = Hook.find_by!(token: params[:token])
    hook.execute!(forwardable_hook_params)

    render text: "done", status: 201
  end

private

  def forwardable_hook_params
    params.except(:token, :action, :controller)
  end
end
