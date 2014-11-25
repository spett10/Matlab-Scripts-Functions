function writefasta(filename,header,seq)
%writefasta writes FASTA format file.
%
%   writefasta(FILENAME, DATA) writes the contents of DATA to file FILENAME
%   in the FASTA format. DATA can be a sequence (or sequences) represented
%   as a character array, a sequence object, a structure containing the
%   fields sequence and header, or a GenBank/GenPept structure.
%
%   writefasta(FILENAME, HEADER, SEQ) writes a FASTA file with header
%   information HEADER and sequence SEQ.
%
%
%   Example:
%
%      %get the sequence for the human p53 gene from GenBank.
%      seq = getgenbank('NM_000546')
%
%      %find the CDS line in the FEATURES information.
%      cdsline = strmatch('CDS',seq.Features)
%
%      %read the coordinates of the coding region.
%      [start,stop] = strread(seq.Features(cdsline,:),'%*s%d..%d')
%
%      %extract the coding region.
%      codingSeq = seq.Sequence(start:stop)
%
%      %write just the coding region to a FASTA file.
%      writefasta('p53coding.txt','Coding region of p53 gene',codingSeq);
%
%      %You can also write multiple sequences from a structure with
%      %writefasta.
%      data(1).Sequence = 'ACACAGGAAA'
%      data(1).Header = 'First sequence'
%      data(2).Sequence = 'ACACAGGAAA'
%      data(2).Header = 'Second sequence'
%      writefasta('twoSequences.fa',data)
%      type('twoSequences.fa')
%
%   See also FASTAINFO, FASTAREAD, FASTQINFO, FASTQREAD, FASTQWRITE,
%   MULTIALIGNWRITE, SEQTOOL, SFFINFO, SFFREAD.

%   Copyright 2002-2009 The MathWorks, Inc.
%   $Revision: 1.11.6.15 $  $Date: 2009/05/07 18:15:25 $

%FASTA format specified here:
%http://www.ncbi.nlm.nih.gov/BLAST/fasta.html

%bioinfochecknargin(nargin,2,mfilename)

if ~ischar(filename),
    error('Bioinfo:writefasta:FilenameMustBeString','FILENAME must be a string.');
end

% The default behavior is to append to the file. If the file exists we
% warn, however, we don't want to warn about appending until we are sure we
% can open the file.
appendFlag = false;
if exist(filename,'file')
    appendFlag = true;
end
fid = fopen(filename,'at');

if fid == (-1)
    [theDir, theFile, theExtension] = fileparts(filename);
    if ~isempty(theDir)
        error('Bioinfo:writefasta:CouldNotOpenFileinDir',...
            'Could not open file %s for writing.\nCheck write permissions in the directory %s.',...
            [theFile, theExtension],theDir);
    else
        error('Bioinfo:writefasta:CouldNotOpenFileinPwd',...
            'Could not open file %s for writing.\nCheck write permissions in the current directory.',...
            filename);
    end
end
if appendFlag
    warning('Bioinfo:writefasta:AppendToFile',...
        '%s already exists. The data will be appended to the file.',filename);
end
try
    if nargin == 2
        % see if we have a sequence or a structure
        if ischar(header)
            seq = header;
            header = sprintf('Generated by MATLAB %s',datestr(now));
            numSequences = size(seq,1);
        elseif isstruct(header)
            try
                seq = char(header.Sequence);
            catch alLExceptions
                error('Bioinfo:writefasta:NoSequenceInStructure','Data structure does not have field ''Sequence''.');
            end
            try
                noHeader = false;
                numSequences = size(seq,1);
                if isfield(header,'Header')
                    header = char(header.Header);
                elseif isfield(header,'GI')  % GenBank/GenPept
                    newheader = cell(numSequences,1);
                    for i=1:numSequences
                        newheader{i} = ['gi|' header(i).GI '|gb|' header(i).Version '| ' header(i).Definition];
                    end
                    header = char(newheader);
                elseif isfield(header,'Identification')  % EMBL
                    newheader = cell(numSequences,1);
                    for i=1:numSequences
                        newheader{i} = ['embl|' header(i).Accession '| ' header(i).Description];
                    end
                    header = char(newheader);
                else
                    noHeader = true;
                end
            catch allExceptions %#ok<NASGU>
                noHeader = true;
            end
            if noHeader
                error('Bioinfo:writefasta:NoHeaderInStructure',...
                    'Data structure does not have field ''Header'' or contain GenBank/GenPept or EMBL data.');
            end
        else
            error('Bioinfo:writefasta:BadData','Data is not a valid sequence or structure.')
        end
    else
        seq = char(seq);
        numSequences = size(seq,1);
        header = char(header);
    end

    for i=1:numSequences
        currseq = deblank(char(seq(i,:)));
        currheader = deblank(char(header(i,:)));
        len = size(currseq,2);
        if len == 0
            error('Bioinfo:writefasta:EmptySeq','Sequence is empty.');
        end
        % Add the > token if needed
        if isempty(currheader) || currheader(1) ~= '>'
            fprintf(fid,'>%s\n',currheader);
        else
            fprintf(fid,'%s\n',currheader);
        end
        maxcols = 70; % NCBI uses 70 columns for their FASTA files
        for line = 1:ceil(len/maxcols);
            start = ((line - 1) * maxcols) + 1;
            stop = min((line * maxcols),len);
            fprintf(fid,'%s\n',currseq(start:stop));
        end
        fprintf(fid,'\n');
    end
    fclose(fid);
catch le
    % close
	fclose(fid);
	
	% delete only if it was a newly created file
	if ~appendFlag
		delete(filename);
	end

    %rethrow the error
    rethrow(le);
end