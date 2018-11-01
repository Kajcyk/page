class Zdjecie < ApplicationRecord
  belongs_to :galerie

  has_attached_file :zdjecie,
                    styles: { :medium => "600x600>", :thumb => "200x200>" }

  validates_attachment_content_type :zdjecie,
                                    :content_type => /\Aimage\/(png|gif|jpeg)/,
                                    :message => '--- akceptuje tylko pliki PNG GIF i JPG ---'

  validates_attachment_size :zdjecie,
                            :in => 0..850.kilobytes,
                            :message => '--- za duży plik max rozmiar to 850 kB ---'

  validates :nazwa,
            :presence => true,
            :length => {:maximum => 120, :message => ": Za długi tytuł zdjęcia"}

  scope :widoczne, lambda {where(:widoczne => true)}
  scope :niewidoczne, lambda {where(:widoczne => false)}
  scope :sortuj, lambda {order("zdjecies.pozycja ASC")}
  scope :najnowsze, lambda {"zdjecies.created_at DESC"}

end
