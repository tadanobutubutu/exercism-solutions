def is_criticality_balanced(temperature, neutrons_emitted):
    return temperature < 800 and neutrons_emitted > 500 and (temperature * neutrons_emitted) < 500000

def reactor_efficiency(voltage, current, theoretical_max_power):
    generated_power = voltage * current
    efficiency = (generated_power / theoretical_max_power) * 100
    if efficiency >= 80:
        return 'green'
    if efficiency >= 60:
        return 'orange'
    if efficiency >= 30:
        return 'red'
    return 'black'

def fail_safe(temperature, neutrons_produced_per_second, threshold):
    value = temperature * neutrons_produced_per_second
    if value < 0.9 * threshold:
        return 'LOW'
    if 0.9 * threshold <= value <= 1.1 * threshold:
        return 'NORMAL'
    return 'DANGER'
