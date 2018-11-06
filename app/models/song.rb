class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def note_contents=(notes)
    notes.map do |note|
      if !note.empty?
        Note.create(content: note, song: self)
      end
    end    
  end

  def note_contents
    notes_array = Note.all.select do |note|
      note.song == self
    end
    notes_array.map do |n|
      n.content
    end
  end

  def artist_name=(artist_name)
    self.artist = Artist.find_or_create_by(name: artist_name)
  end

  def artist_name
    self.artist ? self.artist.name : nil 
  end

  def genre_name=(genre_name)
    self.genre = Genre.find_by(name: genre_name)
  end

  def genre_name
    self.genre.name
  end

end
