class BlockSerializer < ActiveModel::Serializer
  attributes :id, :block_id, :blocked_id
end
