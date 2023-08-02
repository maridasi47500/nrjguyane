class HitController < ApplicationController
  protect_from_forgery except: [:getsongs]
  def post
    render_not_found
  end
  def myhit
    render_not_found
  end
  def event
    render_not_found
  end

  def historique
  end
  def getsongs
    x=[myparams["datePassage(1i)"].to_i,                         myparams["datePassage(2i)"].to_i,                        myparams["datePassage(3i)"].to_i,                        myparams["datePassage(4i)"].to_i,                        myparams["datePassage(5i)"].to_i]
    p x
    somedate=""
    somedate = DateTime.new(myparams["datePassage(1i)"].to_i, 
                        myparams["datePassage(2i)"].to_i,
                        myparams["datePassage(3i)"].to_i,
                        myparams["datePassage(4i)"].to_i,
                        myparams["datePassage(5i)"].to_i)

    @songs=Song.findmysong(somedate)
    render layout: false
  end
  private
  def myparams
    params.permit("datePassage(1i)", "datePassage(2i)","datePassage(3i)", "datePassage(4i)", "datePassage(5i)")
  end
end
