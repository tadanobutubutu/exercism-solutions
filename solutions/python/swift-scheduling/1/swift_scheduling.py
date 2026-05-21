from datetime import datetime, timedelta


def delivery_date(start, description):
    """Convert delivery date descriptions to actual dates.
    
    Args:
        start: ISO format datetime string when the meeting started
        description: Description of delivery (NOW, ASAP, EOW, NM, QN)
    
    Returns:
        ISO format datetime string of delivery date
    """
    start_dt = datetime.fromisoformat(start)
    
    if description == "NOW":
        # Two hours after meeting
        delivery = start_dt + timedelta(hours=2)
    
    elif description == "ASAP":
        # Before 13:00 -> today at 17:00
        # At/after 13:00 -> tomorrow at 13:00
        if start_dt.hour < 13:
            delivery = start_dt.replace(hour=17, minute=0, second=0, microsecond=0)
        else:
            delivery = (start_dt + timedelta(days=1)).replace(hour=13, minute=0, second=0, microsecond=0)
    
    elif description == "EOW":
        # Monday(0)-Wednesday(2): Friday at 17:00
        # Thursday(3)-Friday(4): Sunday at 20:00
        day_of_week = start_dt.weekday()
        
        if day_of_week <= 2:  # Mon-Wed
            days_to_friday = 4 - day_of_week
            delivery = (start_dt + timedelta(days=days_to_friday)).replace(hour=17, minute=0, second=0, microsecond=0)
        else:  # Thu-Fri
            days_to_sunday = 6 - day_of_week
            delivery = (start_dt + timedelta(days=days_to_sunday)).replace(hour=20, minute=0, second=0, microsecond=0)
    
    elif description.endswith("M"):
        # Format: NM (month in target year)
        month_num = int(description[:-1])
        year = start_dt.year
        
        # If we're before the target month, use this year
        # If we're in or after the target month, use next year
        if start_dt.month < month_num:
            target_year = year
        else:
            target_year = year + 1
        
        # Find first workday of that month
        current = datetime(target_year, month_num, 1, 8, 0, 0)
        while current.weekday() >= 5:  # 5=Saturday, 6=Sunday
            current += timedelta(days=1)
        delivery = current
    
    elif description.startswith("Q"):
        # Format: QN (quarter in target year)
        quarter_num = int(description[1])
        year = start_dt.year
        
        # Quarter months: Q1=1-3, Q2=4-6, Q3=7-9, Q4=10-12
        quarter_start_month = (quarter_num - 1) * 3 + 1
        quarter_end_month = quarter_num * 3
        
        # Determine current quarter
        current_quarter = (start_dt.month - 1) // 3 + 1
        
        # If current quarter is before target quarter, use this year
        # If current quarter is after target quarter, use next year
        # If current quarter equals target quarter, use this year (unless after quarter end)
        if current_quarter <= quarter_num:
            target_year = year
        else:
            target_year = year + 1
        
        # Find last workday of quarter end month
        # Start from last day of month and work backwards
        if quarter_end_month == 12:
            next_month_first = datetime(target_year + 1, 1, 1)
        else:
            next_month_first = datetime(target_year, quarter_end_month + 1, 1)
        
        last_day = (next_month_first - timedelta(days=1)).day
        current = datetime(target_year, quarter_end_month, last_day, 8, 0, 0)
        
        while current.weekday() >= 5:  # 5=Saturday, 6=Sunday
            current -= timedelta(days=1)
        delivery = current
    
    return delivery.isoformat()
