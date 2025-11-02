class Api::V1::HealthCheckController < ApplicationController
  def index
    render json: { status: 'ok' }
  end
end
