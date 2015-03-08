require 'rails_helper'

describe HomeController do

  render_views

  it 'renders homes' do
    get :index
    expect(response).to render_template(:index)
  end

end
