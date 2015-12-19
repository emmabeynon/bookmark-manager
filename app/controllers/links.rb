class Bookmarks < Sinatra::Base

  get '/links' do
    @links = Link.all
    erb(:'links/index')
  end

  get '/links/new' do
    erb(:'links/new')
  end

  post '/links' do
    link = Link.new(title: params[:title], url: params[:url])
    params[:tags].split(', ').each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect '/links'
  end

end
