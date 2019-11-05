class User::AddressesController < User::BaseController
  def new
  end

  def create
    address = current_user.addresses.new(address_params)
    if address.save
      flash[:success] = 'You added an address to your profile!'
      redirect_to '/profile'
    else
      flash.now[:error] = address.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = 'Address has been updated!'
      redirect_to profile_path
    else
      flash.now[:error] = @address.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.delete
    redirect_to '/profile'
  end

  private
  def address_params
    params.require(:address).permit(:address, :city, :state, :zip, :use)
  end

end
