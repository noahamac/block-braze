include: "//@{CONFIG_PROJECT_NAME}/views/campaign_enrollment_event.view.lkml"


view: campaign_enrollment_event {
  extends: [campaign_enrollment_event_config]
}

###################################################

view: campaign_enrollment_event_core {
  sql_table_name: braze.CAMPAIGN_ENROLLMENT_EVENT ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
    description: "id of the campaign if from a campaign"
  }

  dimension_group: campaign_updated {
    type: time
    sql: PARSE_TIMESTAMP('%Y-%m-%dT%H:%M:%S', ${TABLE}.campaign_updated_at) ;;
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year]
  }

  dimension: external_user_id {
    type: number
    sql: ${TABLE}.external_user_id ;;
    hidden: yes
    description: "external ID of the user"
  }

  dimension: message_variation_id {
    type: number
    sql: ${TABLE}.message_variation_id ;;
    hidden: yes
    description: "id of the message variation if from a campaign"
  }

  dimension: send_id {
    type: number
    sql: ${TABLE}.send_id ;;
    hidden: yes
    description: "id of the message if specified for the campaign"
  }

  dimension_group: time {
    label: ""
    type: time
    sql: PARSE_TIMESTAMP('%Y-%m-%dT%H:%M:%S', ${TABLE}.time) ;;
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_month_num,
      fiscal_quarter,
      fiscal_quarter_of_year,
      fiscal_year]
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
    description: "IANA timezone of the user at the time of the event"
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    hidden: yes
    description:"braze user id of the user"
  }

  measure: count {
    type: count
    drill_fields: [id, message_variation.name, message_variation.id, campaign.name, campaign.id]
  }
}