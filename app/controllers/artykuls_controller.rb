class ArtykulsController < ApplicationController

  layout 'admin'

  before_action :sprawdz_logowanie
  before_action :szukaj_strony

  def index
    @artykuly = @strony.artykuls.sortuj
  end

  def nowy
    @artykuly = Artykul.new(:nazwa => "Tytuł?")
    @strona = Strona.order('pozycja ASC')
    @licznik = Artykul.count + 1
  end

  def utworz
    @artykuly = Artykul.new(artykuly_parametry)
    if @artykuly.save
      flash[:notice] = "Artykuł został pomyślnie utworzony"
      redirect_to(:action => 'index')
    else
      @licznik = Artykul.count + 1
      @strona = Strona.order('pozycja ASC')
      render('nowy')
    end
  end

  def edycja
    @artykuly = Artykul.find(params[:id])
    @strona = Strona.order('pozycja ASC')
    @licznik = Artykul.count
  end

  def aktualizuj
    @artykuly = Artykul.find(params[:id])
    if @artykuly.update_attributes(artykuly_parametry)
      flash[:notice] = "Artykuł został pomyślnie zmodyfikowany"
      redirect_to(:action => 'pokaz', :id => @artykuly.id)
    else
      @licznik = Artykul.count
      @strona = Strona.order('pozycja ASC')
      render('edycja')
    end
  end

  def usun
    @artykuly = Artykul.find(params[:id])
  end

  def kasuj
    artykuly = Artykul.find(params[:id]).destroy
    flash[:notice] = "Artykuł '#{artykuly.nazwa}' został pomyślnie usunięty"
    redirect_to(:action => 'index')
  end

  def pokaz
    @artykuly = Artykul.find(params[:id])
  end

private
  def artykuly_parametry
    params.require(:artykuly).permit(:strona_id,:nazwa, :pozycja, :widoczny, :created_at, :zdjecie)
  end

  def szukaj_strony
    if params[:strona_id]
      @strony = Strona.find(params[:strona_id])
    end
  end

end