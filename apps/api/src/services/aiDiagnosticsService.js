export class AiDiagnosticsService {
  async analyze({ motorcycle, symptoms, obdCodes }) {
    const hasObd = Array.isArray(obdCodes) && obdCodes.length > 0;

    return {
      severity: hasObd ? 'medium' : 'low',
      confidence: hasObd ? 0.82 : 0.64,
      likelyCauses: hasObd ? ['Sensor fault', 'Fuel or air mixture issue'] : ['Wear item inspection needed'],
      recommendedActions: [
        `Inspect ${motorcycle?.nickname ?? 'motorcycle'} with service history context`,
        'Book workshop visit if symptoms persist',
      ],
      safeToRide: !symptoms?.some((item) => item.toLowerCase().includes('brake')),
    };
  }
}

