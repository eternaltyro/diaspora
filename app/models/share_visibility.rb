#   Copyright (c) 2010-2011, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

class ShareVisibility < ActiveRecord::Base
  belongs_to :contact
  belongs_to :shareable, :polymorphic => :true

  # Perform a batch import, given a set of contacts and a shareable
  # @note performs a bulk insert in mySQL; performs linear insertions in postgres
  # @param contacts [Array<Contact>] Recipients
  # @param share [Shareable]
  # @return [void]
  def self.batch_import(contact_ids, share)
    if postgres?
      contact_ids.each do |contact_id|
        ShareVisibility.find_or_create_by_contact_id_and_shareable_id_and_shareable_type(contact_id, share.id, share.class.base_class.to_s)
      end
    else
       new_share_visibilities_data = contact_ids.map do |contact_id|
        [contact_id, share.id, share.class.base_class.to_s]
      end
      ShareVisibility.import([:contact_id, :shareable_id, :shareable_type], new_share_visibilities_data)
    end
  end
end
