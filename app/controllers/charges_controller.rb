class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Membership - #{current_user.email}",
      amount: 15_00
      }
  end
  
  def create
    @user = current_user
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
  
    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: 15_00,
      description: "Blocipedia Membership - #{current_user.email}",
      currency: 'usd'
    )
    
    @user.update(role: 'premium')
    flash[:success] = "Thanks for your subscription, #{current_user.name}!"
    redirect_to root_path
  
    # Stripe will send back CardErrors, with friendly messages when something goes wrong.
    # This 'rescue block' catches and displays those errors.
    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  
  end
  
  def downgrade
    @user = current_user
    @user.update(role: 'standard')
    @user.make_wikis_public
    redirect_to root_path
  end
  
end