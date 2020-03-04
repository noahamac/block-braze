include: "//@{CONFIG_PROJECT_NAME}/card_tag.view.lkml" 
        
        
view: card_tag {
  extends: [card_tag_config]
}

###################################################
        
view: card_tag_core {
  sql_table_name: braze.CARD_TAG ;;

  dimension: card_id {
    type: number
    sql: ${TABLE}.card_id ;;
  }

  dimension: card_updated_at {
    type: string
    sql: ${TABLE}.card_updated_at ;;
  }

  dimension: tag {
    type: string
    sql: ${TABLE}.tag ;;
  }

  measure: count {
    type: count
    drill_fields: [card.name, card.id]
  }
}