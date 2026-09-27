export function removeDuplicates(playlist) {
  return Array.from(new Set(playlist));
}

export function hasTrack(playlist, track) {
  return new Set(playlist).has(track);
}

export function addTrack(playlist, track) {
  const tracks = new Set(playlist);
  tracks.add(track);
  return Array.from(tracks);
}

export function deleteTrack(playlist, track) {
  const tracks = new Set(playlist);
  tracks.delete(track);
  return Array.from(tracks);
}

export function listArtists(playlist) {
  const artists = new Set();
  for (const track of playlist) {
    const separator = track.lastIndexOf(' - ');
    if (separator !== -1) artists.add(track.slice(separator + 3));
  }
  return Array.from(artists);
}
